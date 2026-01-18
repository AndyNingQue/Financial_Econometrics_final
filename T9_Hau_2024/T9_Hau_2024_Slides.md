---
marp: true
theme: default
paginate: true
size: 16:9
style: |
  section {
    font-size: 24px;
    padding: 50px;
  }
  h1 {
    color: #2c3e50;
  }
  h2 {
    color: #34495e;
    border-bottom: 2px solid #3498db;
    padding-bottom: 10px;
  }
  strong {
    color: #e74c3c;
  }
  img {
    background-color: transparent;
  }
  table {
    font-size: 20px;
  }
---

# FinTech 信用与创业增长
## FinTech Credit and Entrepreneurial Growth

**Journal of Finance (2024)**

Hau, H., Huang, Y., Lin, C., Shan, H., Sheng, Z., & Wei, L.

---

# 目录

1. **研究背景与问题** (Background & Motivation)
2. **数据与研究设计** (Data & Methodology)
3. **实证结果分析** (Empirical Results)
   - 城市层面证据
   - 断点回归 (RDD) 核心结果
4. **异质性分析** (Heterogeneity Analysis)
5. **机制检验** (Mechanism)
6. **稳健性检验** (Robustness Checks)
7. **结论与启示** (Conclusion)

---

# 1. 研究背景与问题
### Background & Motivation

---

## 1.1 研究背景：信贷鸿沟

- **核心痛点**：在发展中经济体，小微企业（MSMEs）面临严重的信贷约束。
- **传统银行的局限**：
  - 依赖**硬信息**（Hard Information）：如完善的财务报表。
  - 依赖**抵押品**（Collateral）：如房产、土地。
  - **结果**：缺乏抵押资产、财务不透明的小微企业被排斥在信贷市场之外。
- **FinTech 的兴起**：
  - 基于**大数据与算法**的自动化信贷。
  - 能够利用非传统数据（交易流、支付记录、客户评价）进行风险定价。

---

## 1.2 核心研究问题

**FinTech 信贷能否真正跨越“信贷鸿沟”，解锁小微企业的增长潜力？**

- **具体考察**：
  1. 获得信贷后，小微企业的**规模**（销售、交易量）是否增长？
  2. 企业的**经营质量**（客户满意度、服务质量）是否提升？
  3. FinTech 信贷是否具有**普惠性**（即对传统银行难以覆盖的群体效果更佳）？

---

## 1.3 数据来源与样本概况

- **数据来源**：蚂蚁集团 (Ant Group) & 阿里巴巴电商平台。
- **样本范围**：
  - 时间：2014年9月 — 2016年7月。
  - 对象：淘宝平台上的活跃商户。
- **数据规模**：
  - **340 万**家活跃商户。
  - 超过 **3550 万**个“企业-月”观测值。
- **关键变量**：
  - 信贷审批记录（批准与否、额度）。
  - 高频经营数据（销售额、订单量、DSR评分）。

---

# 2. 数据与研究设计
### Data & Methodology

---

## 2.1 识别策略：模糊断点回归 (Fuzzy RDD)

- **内生性挑战**：获得贷款的企业往往本身资质更好（选择性偏差）。
- **制度性阈值**：
  - 蚂蚁集团信贷审批存在一个明确的**信用评分阈值 (480分)**。
  - **评分 $\ge$ 480**：获批概率显著跳跃（提升约 29%）。
  - **评分 < 480**：获批概率较低。
- **局部实验环境**：
  - 在 480 分附近的商家，特征高度相似。
  - 唯一的区别在于是否“幸运”地跨过了门槛。
- **方法**：比较阈值两侧企业的经营表现，识别因果效应。

---

## 2.2 FRDD 模型设定 (2SLS)

**第一阶段 (First Stage):**
$$CreditApproval_{i,t} = \alpha + \rho \cdot IV_{i,t} + \sum_{k=1}^{K}\gamma^{k}S_{i,t}^{k} + \varphi_{j} + \varphi_{t} + \epsilon_{i,t}$$

- $IV_{i,t} = \mathbf{1}(Score_{i,t-1} \ge 480)$：是否跨过阈值的工具变量。
- $S_{i,t}$：中心化分配变量 ($Score - 480$)。

**第二阶段 (Second Stage):**
$$Y_{i,t+1} = \beta + \tau \cdot \widehat{CreditApproval}_{i,t} + \sum_{k=1}^{K}\lambda^{k}S_{i,t}^{k} + \varphi_{j} + \varphi_{t} + \varepsilon_{i,t}$$

- **$\tau$ (LATE)**：我们要识别的核心因果效应。
- $Y_{i,t+1}$：销售增长、交易增长、客户评分等。

---

## 2.3 描述性统计 (局部 FRDD 样本)

![bg right:55% fit](https://fig-lianxh.oss-cn-shenzhen.aliyuncs.com/20260118002254914.png)

- **样本限制**：信用评分 $[460, 500]$。
- **核心变量**：
  - **Sales Growth**：月度销售额增长率。
  - **Credit Approval**：授信状态。
  - **Ratings**：产品、服务、物流评分 (标准化至 0-1)。
- **控制变量**：
  - 商家年龄、行业分散度、是否有房产、广告支出等。

---

# 3. 实证结果分析
### Empirical Results

---

## 3.1 城市层面证据：宏观环境与平台进入

![bg right:50% fit](https://fig-lianxh.oss-cn-shenzhen.aliyuncs.com/20260118002409459.png)

**结论：**
在**国有银行网点密度高**且**国企产出占比高**的城市：
1. 更多创业者选择**进入淘宝平台** (Col 1)。
2. 更多商家使用 **FinTech 信贷** (Col 2-3)。

**启示**：
线上平台是创业者规避线下金融抑制的有效渠道。

---

## 3.2 识别假设检验：不可操纵性

**Figure 1A: 信用评分分布**

- **观察**：评分在 480 阈值附近分布平滑，无异常堆积。
- **检验**：McCrary / Cattaneo–Jansson–Ma 密度检验通过 ($p$-value = 0.88)。
- **结论**：商家无法精准操纵评分，RDD 设计有效。

![h:300 center](https://fig-lianxh.oss-cn-shenzhen.aliyuncs.com/20260118002543245.png)

---

## 3.3 第一阶段：授信概率的跳跃

**Figure 1B: First Stage Discontinuity**

- **观察**：在信用评分 480 处，获得信贷批准的概率出现了显著的向上跳跃。
- **幅度**：约为 29 个百分点的概率提升。
- **结论**：阈值具有很强的工具变量效力 (Strong IV)。

![h:350 center](https://fig-lianxh.oss-cn-shenzhen.aliyuncs.com/20260118002622682.png)

---

## 3.4 基准回归结果：销售与交易增长 (Table III)

![bg right:50% fit](https://fig-lianxh.oss-cn-shenzhen.aliyuncs.com/20260118002704452.png)

**FinTech 信贷显著促进了企业增长：**

1. **Sales Growth (Col 1)**: 
   系数 0.3631 $\rightarrow$ 实际增长约 **44%**。
   
2. **Transaction Growth (Col 2)**:
   系数 0.2691 $\rightarrow$ 实际增长约 **31%**。

*注：控制了行业与时间固定效应。*

---

## 3.5 基准回归结果：客户资本积累

**信贷不仅带来“量”的增长，还带来“质”的提升：**

- **Product Rating (Col 3)**: 产品评分显著提升。
- **Service Rating (Col 4)**: 服务评分显著提升。
- **Consignment Rating (Col 5)**: 物流评分显著提升。

**经济含义**：信贷资金被用于改善客户体验，从而积累了无形资产（客户资本）。

---

# 4. 异质性分析：FinTech 的相对优势
### Heterogeneity Analysis

---

## 4.1 信息渠道 (Information Channel)

**逻辑**：FinTech 擅长处理大数据，不依赖传统“硬信息”。因此，**信息不对称严重**的商家应受益更多。

**Table IV 结果**：
- **Age Rank (年轻商家)**：交互项系数显著为负。
  $\rightarrow$ **越年轻的商家，获贷后增长效应越强**。
- **High Dispersion (高风险行业)**：交互项系数显著为正。
  $\rightarrow$ **行业波动性大的商家，获贷后增长效应更强**。

**结论**：FinTech 填补了传统银行在评估年轻、高风险企业时的空白。

---

## 4.2 抵押品替代渠道 (Collateral Substitute)

**逻辑**：FinTech 不依赖抵押品。因此，**缺乏抵押资产**的商家应受益更多。

**Table V 结果**：
- **High Durability (耐用品)**：交互项显著为负。
  $\rightarrow$ 非耐用品（难抵押）行业受益更多。
- **Property Ownership (拥有房产)**：交互项显著为负。
  $\rightarrow$ **无房产的商家，获贷后增长效应显著更强**。

**结论**：数据和算法成功替代了实物抵押品的功能。

---

# 5. 机制检验：信用如何转化为增长？
### Mechanisms

---

## 5.1 运营机制：短期可逆投资 (Table VI)

![bg right:45% fit](https://fig-lianxh.oss-cn-shenzhen.aliyuncs.com/Hau-2024-Fig21-Table%20VI%20%E5%8E%9F%E6%96%87%E7%BB%93%E6%9E%9C-%E5%AD%99%E6%B3%BD%E5%B9%B3.png)

商家获得资金后做了什么？

1. **广告投入 (Advertisement)**: 
   增加约 **31%** $\rightarrow$ 获取流量。
2. **产品品类 (Product Variety)**:
   增加约 **13%** $\rightarrow$ 满足长尾需求。
3. **转化率 (Conversion Rate)**:
   显著提升 $\rightarrow$ 改善客服与展示。

**结论**：流动性缓解支持了运营优化，直接驱动业绩增长。

---

## 5.2 成本效益与流动性保险

- **高利率问题**：年化利率约 17%，为何没有抑制增长？
  - **高周转**：电商库存周转快，还款周期短（中位数 6 周）。
  - **实际成本**：利息支出占贷款额比例仅为 **2.7%**。

- **流动性保险 (Liquidity Insurance)**：
  - 仅 17% 的额度被实际提取。
  - **存在即价值**：拥有额度降低了商家的预防性储蓄动机，使其敢于投入自有资金。

---

# 6. 稳健性检验
### Robustness Checks

---

## 6.1 时间窗口与变量定义

- **更长窗口 (Table VII Panel A)**：
  - 考察连续 3 个月的授信效果。
  - 结果：系数更大，**持续授信带来更强的累积增长**。

- **评分变化量 (Table VII Panel B)**：
  - 使用 $\Delta Rating$ 替代水平值。
  - 结果：依然显著，排除了初始水平差异的干扰。

---

## 6.2 函数形式与带宽选择

- **函数形式**：
  - **Panel C**: 允许左右两侧斜率不同 (Differential Slopes)。
  - **Panel D**: 使用二阶多项式控制 (Quadratic Polynomial)。
  - **结果**：核心结论稳健。

- **带宽选择**：
  - **Panel E/F**: 缩小带宽至 $[465, 495]$ 和 $[470, 490]$。
  - **结果**：尽管样本量减少，显著性依然存在。

---

## 6.3 安慰剂检验 (Placebo Test)

- **方法**：在非 480 分处随机生成“虚构阈值” (Falsified Cutoffs)。
- **结果**：
  - 虚构阈值处的第一阶段回归**不存在**显著的概率跳跃。
  - 估计值接近于 0。
- **含义**：本文发现的效应确实源于 480 分这一制度性门槛，而非数据噪音。

---

## 6.4 长期效果 (Table VIII)

**考察授信后第 6 个月的绩效：**

- **销售与交易**：增长效应依然显著。
- **运营指标**：广告投入、产品种类、转化率的提升具有持续性。

![h:250 center](https://fig-lianxh.oss-cn-shenzhen.aliyuncs.com/Hau-2024-Fig35-Table%20VIII%20%E5%8E%9F%E6%96%87%E7%BB%93%E6%9E%9C-%E5%AD%99%E6%B3%BD%E5%B9%B3.png)


---
# 7. 文献拓展与讨论
### Literature Extensions & Discussion

---

## 7.1 扩展一：FinTech 的市场准入 (Extensive Margin)

**Hau, H., Huang, Y., Shan, H., & Sheng, Z. (2019).** *AEA Papers and Proceedings*

- **研究视角**：主文关注“获贷后的增长”(Intensive)，本文关注“谁获得了贷款”(Extensive)。
- **核心发现**：
  1. **逆向选择特征**：信用评分越低（高风险）的商家，FinTech 信贷使用率反而越高 (39% vs 16%)。
  2. **补位效应**：在银行网点稀缺、国企主导的地区，FinTech 需求更旺盛。
- **与主文联系**：
  解释了为何年轻、无抵押企业受益最大——因为 FinTech 的算法本身就是为了**精准捕获 (Targeting)** 这些被银行遗忘的群体。

---

## 7.2 扩展二：行业跨越——从电商到农业

**Zhang, H., Wang, Y., & Wang, X. (2024).** *Economic Analysis and Policy*

- **场景拓展**：从“电商零售”延伸至“农业生产” (CFPS数据)。
- **核心发现**：
  - **显著增收**：BigTech 金融使用每增加 1 个标准差，农业收入增加约 25%。
  - **亲贫性 (Pro-poor)**：仅收入最低的 20% 农户有显著增收效应。
- **独特机制**：
  1. **要素投入**：增加种子、化肥、土地租赁支出。
  2. **风险缓冲**：帮助农户抵御自然灾害冲击。

---

## 7.3 扩展三：全球视野与理论框架

**Berg, T., Fuster, A., & Puri, M. (2022).** *Annual Review of Financial Economics*

- **理论贡献**：区分 FinTech (纯金融科技) vs **BigTech** (大型科技公司，如蚂蚁)。
- **核心机制——范围经济 (Economies of Scope)**：
  - BigTech 利用电商/社交产生的非金融数据（“数字足迹”），产生**信息溢出**。
  - **软信息硬化**：将口碑、退货率等模糊信息转化为标准化的“硬信息”。
- **风险提示**：
  - 需警惕监管套利 (Regulatory Arbitrage) 与算法歧视。

---

# 8. 复现与思考
### Replication & Personal Thoughts

---

## 8.1 复现工作概述 (Replication Summary)
![bg right:40% fit](https://fig-lianxh.oss-cn-shenzhen.aliyuncs.com/Hau-2024-Fig07-Table%20III%20Panel%20A%E5%A4%8D%E7%8E%B0%E7%BB%93%E6%9E%9C-%E5%AE%81%E7%A1%AE1.png)

- **复现工具**：Stata / Python
- **复现数据**：基于原文提供的 Replication Package / 模拟数据
- **复现结果一致性**：
  - **断点图 (First Stage)**：成功复现了 480 分处的概率跳跃。
  - **主回归 (Table III)**：销售增长与交易增长系数与原文高度接近，显著性一致。
  - **稳健性**：更换带宽后结果依然稳健。

---

## 8.2 学习心得与局限性思考

- **方法论收获**：
  - 深入理解了 **Fuzzy RDD** 的识别假设（不可操纵性、连续性）。
  - 掌握了处理内生性交互项 (Interaction Terms) 的 2SLS 写法。
- **对原文的思考**：
  - **局限性**：结论主要基于 2014-2016 年数据，当前监管环境（如断直连、利率上限）已发生变化，结论是否依然适用？
  - **外部有效性**：电商的高周转率是高利率借贷可行的关键，该模式是否能复制到低周转行业（如制造业）？

---

# 9. 结论与启示
### Conclusion & Implications

---

## 9.1 核心结论总结

1. **强劲的增长引擎**：FinTech 信贷显著提升了小微企业的销售额 (**+44%**) 和交易量 (**+31%**)。
2. **质量提升**：信贷不仅带来规模扩张，还通过改善服务和物流提升了**客户满意度**。
3. **精准普惠**：
   - **年轻企业**受益更多（克服信息不对称）。
   - **无房产企业**受益更多（克服抵押品约束）。
4. **作用机制**：通过支持广告、扩品类和提升转化率等**短期运营投资**实现增长。

---

## 9.2 政策启示

1. **补充而非替代**：
   FinTech 有效覆盖了传统银行难以触及的“长尾”市场（年轻、无抵押小微企业）。
2. **数据作为新型抵押品**：
   证明了基于交易数据和算法的“硬信息”风控是有效的，可以替代实物抵押。
3. **基础设施建设**：
   鼓励征信数据的标准化与跨平台共享，有助于进一步降低全社会的信贷摩擦。

---


# 10. 参考文献与扩展阅读
### References & Further Reading

---

## 参考文献

**主讲论文 (Main Paper)**
- Hau, H., Huang, Y., Lin, C., Shan, H., Sheng, Z., & Wei, L. (2024). FinTech Credit and Entrepreneurial Growth. *The Journal of Finance*, 79(5), 3309–3359.

**相关扩展文献 (Extensions)**
- **市场准入 (Market Entry)**: Hau, H., Huang, Y., Shan, H., & Sheng, Z. (2019). How FinTech Enters China’s Credit Market. *AEA Papers and Proceedings*.
- **行业拓展 (Agriculture)**: Zhang, H., Wang, Y., & Wang, X. (2024). The impact of financial deepening on agricultural production. *Economic Analysis and Policy*.
- **理论综述 (Global View)**: Berg, T., Fuster, A., & Puri, M. (2022). FinTech Lending. *Annual Review of Financial Economics*.

---

# 谢谢观看
## Q & A

